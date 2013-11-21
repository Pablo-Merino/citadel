require 'json'
module Citadel
	class Core
    attr_reader :in_process
		attr_accessor :database

    def initialize(args)
      if !args[0].nil?
        load args[0] 
      else
        raise ArgumentError, "config file is nil"
      end
      
      if !Dir.exist?(File.expand_path(Settings[:working_dir]))
        Dir.mkdir(File.expand_path(Settings[:working_dir]))
      end      
      
      @working_dir = File.expand_path(Settings[:working_dir])

      @database = Datastore::Connection.new
      if !Dir.exist?("#{File.expand_path(Settings[:working_dir])}/code/.git")
        open_pipe("cd #{File.expand_path(Settings[:working_dir])} && git clone #{Settings[:clone_url]} ./code") do |pipe, pid|
          Process.wait(pid)
          Server.start(self)
        end
      else
        Server.start(self)
      end
      
    end

    def run_spec
      open_pipe("cd #{@working_dir}/code && #{Settings[:command]}") do |pipe, pid|
        Process.wait(pid)
        @pipe = pipe
      end
      pipe_content = @pipe.read
      is_success = false
      if $?.to_i == 0
        is_success = true
      end
      hash = {:sha => git_sha, :result =>  is_success, :started => Time.now, :error_data => pipe_content}
      begin
        @database.inspections.insert(hash)
        Settings[:after_testing].call(hash)
        {:success => true}
      rescue Sequel::ConstraintViolation => e
        Settings[:after_testing].call(hash)
        {:success => false, :data => [pipe_content, git_sha], :already => true}
      end
    end

    def pull_git_repo(start_tests)
      open_pipe("git --git-dir=#{@working_dir}/code fetch origin && git --git-dir=#{@working_dir}/code reset --hard origin/#{Settings[:branch]}") do |pipe, pid|
        Process.wait(pid)
      end
      run_spec if start_tests and $?.success?
    end

    def pull_git_repo!
      pull_git_repo(true)
    end

    def git_sha
      `cd #{@working_dir}/code && git rev-parse origin/#{Settings[:branch]}`.chomp
    end

    def latest_git_sha
      `cd #{@working_dir}/code && git ls-remote ./ head`.chomp.gsub(/HEAD/, '')
    end

    private
    def open_pipe(cmd)
      read, write = IO.pipe
      @in_process = true
      pid = fork do
        read.close
        $stdout.reopen write
        exec cmd
      end

      write.close
      @in_process = false

      yield read, pid
    end
	end

end
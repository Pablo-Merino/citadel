module Citadel

  module Settings
    extend self

    def self.configure(&block)
      instance_eval(&block)
    end

    def settings  
      @settings ||= Hash.new  
    end

    def command(cmd='rake spec')
      settings[:command] = cmd
    end

    def branch(branch='master')
      settings[:branch] = branch
    end

    def username(username='citadel')
      settings[:username] = username
    end

    def password(password='')
      settings[:password] = password
    end

    def working_dir(dir='./')
      settings[:working_dir] = dir
    end

    def github_url(url="")
      settings[:github_url] = url
    end
    
    def clone_url(url="")
      settings[:clone_url] = url
    end
    
    def after_testing(&block)
      settings[:after_testing] = block
    end

    def [](conf)
      settings[conf]
    end 

    def inspect
      p settings
    end
  end

end
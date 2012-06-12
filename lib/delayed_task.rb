module DelayedTask
  require 'rake'
  class PerformableTask < Struct.new(:task_name, :targs)
    def perform
      begin
        task = Rake::Task[task_name]
        args = {}
        targs.each_with_index { |arg,i| args[task.arg_names[i]] = arg }
        puts "Executing task: #{task.name} #{args.inspect}"
        task.execute args
      rescue Exception => e
        args = targs.count > 0 ? "[#{targs.join(',')}]" : ''
        cmd  = "rake #{task_name}#{args}"
        puts "Exception: #{e.inspect}"
        puts "Executing command: `#{cmd}`"
        system cmd
      end
    end
  end
end

module DelayedTask
  class << self
    include Rake::DSL if defined?(Rake::DSL)
    def add_delayed_tasks
      Rake::Task.tasks.each do |task|
        task "delay:#{task.name}", 100.times.map { |i| "arg#{i}".to_sym } do |t, args|
          Rake::Task["environment"].invoke
          Delayed::Job.enqueue DelayedTask::PerformableTask.new(task.name, args.to_hash.values)
          args = args.count > 0 ? "[#{args.to_hash.values.join(',')}]" : ""
          puts "Enqueued job: `rake #{task.name}#{args}`"
        end
      end
    end
  end
end

DelayedTask.add_delayed_tasks

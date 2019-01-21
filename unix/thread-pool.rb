POOL_SIZE = 10

jobs = Queue.new # thread-safe (so if multiple threads access it at the same time, it will maintain consistency) 

10_0000.times{|i| jobs.push i}

workers = (POOL_SIZE).times.map do
  Thread.new do # Within each worker thread, we pop items from the jobs queue.
    begin      
      while x = jobs.pop(true)
        Mailer.deliver do 
          from    "eki_#{x}@eqbalq.com"
          to      "jill_#{x}@example.com"
          subject "Threading and Forking (#{x})"
          body    "Some content"
        end        
      end
    rescue ThreadError
    end
  end
end

workers.map(&:join)

#the good news is that this works and scales without any problems. Unfortunately, though, this is fairly complicated.
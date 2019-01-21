# runs 4 tasks in 4 threads and 4 forks and reports the times for each

def time_forks(num_forks)
    beginning = Time.now
    num_forks.times do 
      fork do
        yield
      end
    end
  
    Process.waitall
    return Time.now - beginning
  end
  
  def time_threads(num_threads)
    beginning = Time.now
    num_threads.times do 
      Thread.new do
        yield
      end
    end
  
    Thread.list.each do |t|
      t.join if t != Thread.current
    end
    return Time.now - beginning
  end
  
  def calculate(cycles)
    x = 0
    cycles.times do
      x += 1
    end
  end
  
  cycles = 10000000
  
  threaded_seconds = time_threads(4) {  calculate(cycles) }
  puts "Threading finished in #{threaded_seconds} seconds"
  
  forked_seconds = time_forks(4) {calculate(cycles) }
  puts "Forking finished in #{forked_seconds} seconds"

# Threading finished in 1.395229 seconds
# Forking finished in 0.386197 seconds
# Using forks took 1/4 the amount of time to complete when compared to threads. 
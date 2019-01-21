# Sometimes it's useful to wait until all processes have finished
#One way we can prevent the introduction of zombie processes is to wait on child processes to finish. This way, if a child hangs, it will be obvious in the terminal. To do this, just add a call to Process#waitall at the point where you would like the program to block until every fork finishes its work.
#



fork do
    3.times do
      puts "Zombie: brains..."
      sleep 1
    end
    puts "Zombie: blehhh *dies*"
  end
  
Process.waitall

puts "Main: finished"
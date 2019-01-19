puts "parent process pid is #{ Process.pid }"

if fork 
    puts "entered the if block from #{ Process.pid }" # parent process
else 
    puts "entered the else block from #{ Process.pid }" # child process
end 

# in the parent process, fork returns the pid of the 
# newly created child process.

# in the child process, fork returns nil and enters the else block

puts fork 

fork do 
    # code here is only executed in the child process
end 

code here is only executed in the parent process

# communication between processes without the filesystem or network

5.times do 
    fork do 
        if rand(5).even?
            exit 111
        else 
            exit 112
        end 
    end 
end 

5.times do 
    pid, status = Process.wait2
    if status.exitstatus == 111 
        puts "#{pid} encountered an even number!"
    else 
        puts "#{pid} encountered an odd number"
    end 
end 
reader, writer = IO.pipe # [#<IO:fd 10>, #<IO:fd 11>]
writer.write('into the pipe I go')
writer.close
puts reader.read #into the pipe I go

# sharing pipes
reader, writer = IO.pipe 
fork do 
    reader.close 

    10.times do 
        #heavy lifiting
        writer.puts 'Another one bites the dusk'
    end 
end

writer.close 
while message = reader.gets 
    $stdout.puts message 
end 

# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk
# Another one bites the dusk


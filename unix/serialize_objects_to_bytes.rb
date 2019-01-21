# Since low-level communication constructs like pipes and sockets transfer bytes, not objects, you will need to encode your objects into a byte format — i.e. serialize them — in order to move them across the process barrier.

# Fortunately, Ruby ships with Marshal which can serialize most Ruby objects.

# Ruby objects can be serialized by Marshal to move across pipes
# or sockets

Tire = Struct.new(:radius, :pressure)

reader, writer = IO.pipe

fork do
  reader.close
  tire = Tire.new(7, 28)
  tire_data = Marshal.dump(tire)
  writer.write tire_data
end

writer.close
tire_data = reader.gets
tire = Marshal.load(tire_data)
puts tire.inspect
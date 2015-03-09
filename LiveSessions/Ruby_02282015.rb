def test_method(msg, &blo)
  puts msg
  block.call
end


def test_method(msg)
  puts msg
  yeild if block_given?
end

test_method("hey there!")
  puts "hi again"
end

SELECT <columns> FROM <table> WHERE <conditions>

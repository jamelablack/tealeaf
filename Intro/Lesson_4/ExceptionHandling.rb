To Raise an exception:
RbyWoo: ~/Code/Tealeaf/tealeaf/Intro/Lesson_4 -> irb
2.1.2 :001 > def my_exception(value)
2.1.2 :002?>   if value == false
2.1.2 :003?>     raise TypeError, "You must give me the truth!"
2.1.2 :004?>     end
2.1.2 :005?>   end
 => :my_exception 
2.1.2 :006 > my_excpetion(false)
NoMethodError: undefined method `my_excpetion' for main:Object
	from (irb):6
	from /Users/RbyWoo/.rvm/rubies/ruby-2.1.2/bin/irb:11:in `<main>'
2.1.2 :007 > my_exception(false)
TypeError: You must give me the truth!
	from (irb):3:in `my_exception'
	from (irb):7
	from /Users/RbyWoo/.rvm/rubies/ruby-2.1.2/bin/irb:11:in `<main>'

You can really use raise for anything
2.1.2 :012 > def my_new_exception
2.1.2 :013?>   raise "Hello"
2.1.2 :014?>   end
 => :my_new_exception 
2.1.2 :015 > my_new_exception
RuntimeError: Hello
	from (irb):13:in `my_new_exception'
	from (irb):15
	from /Users/RbyWoo/.rvm/rubies/ruby-2.1.2/bin/irb:11:in `<main>' 

========Using Rescue
begin
  1/0
  p 'I should never get executed'
rescue
  p 'I am rescuing an exception and can do what I want!'
end
This produces the following output:

"I am rescuing an exception and can do what I want!"

=======Using Raise & Rescue
2.1.2 :016 > i=0
 => 0 
2.1.2 :017 > while i<=10
2.1.2 :018?>     begin
2.1.2 :019 >           if i ==0
2.1.2 :020?>             1/0
2.1.2 :021?>           end
2.1.2 :022?>         raise "random runtime exception"
2.1.2 :023?>         p 'I should never get executed'
2.1.2 :024?>       rescue ZeroDivisionError
2.1.2 :025?>         p 'I am rescuing only ZeroDivisionErrors!'
2.1.2 :026?>         i+=1
2.1.2 :027?>       end
2.1.2 :028?>   end
"I am rescuing only ZeroDivisionErrors!"
RuntimeError: random runtime exception
	from (irb):22
	from /Users/RbyWoo/.rvm/rubies/ruby-2.1.2/bin/irb:11:in `<main>'
2.1.2 :029 > 

===============Using Ensure to Run Code Regardless
As you can tell, we rescued the first exceptions since it was a division by zero, but the second exception does not get rescued and so the program exits with an error. However, we sometimes want to execute some code regardless of whether an exception was thrown or not (i.e. we may want to do some cleanup). Java has the finally keyword for this, Ruby has ensure. We can put an ensure clause within out begin .. end block. The code inside this clause gets executed regardless of whether the code throws an exception. For example, if we are reading from a file, we want to close the file handle no matter if an exception is thrown or not, we can do the following:

file = nil
begin
  file = File.open("blah.txt")
  raise
rescue
  p 'I rescue all exception and raise new ones'
ensure
  file.close
  p 'just closed the file'
end
as we expect the output is:

"I rescue all exception and raise new ones"
"just closed the file"
Even though an exception was thrown and rescued, the code in the ensure clause executes regardless.

============Rescuing Exceptions in Methods

Rescuing Exceptions Inside Methods

If we are inside a method and we want to rescue some exceptions, we don’t actually need a begin .. end block since the method definition itself will act in that capacity. So, we can do something like this:

def some_method
  p 'Hello method'
  raise
  p 'Bye method'
rescue
  p 'Rescuing exceptions'
end
some_method
which print out:

"Hello method"
"Rescuing exceptions"
We have rescued an exceptions without having a begin .. end block.


====================Using Rescue for messages

You are not limited to knowing just the type of the exception you’re rescuing, you can get more information at your disposal. When you rescue an exception you can get a hold of the actual exception object that was thrown and then query this object for various details. Here is how:

begin
  raise ZeroDivisionError, "Hello I am a random zero division error"
rescue ZeroDivisionError => e
  p e.message
  p e.backtrace
end
If we execute the above code we will print out the message as well as the stack trace of the exception we rescued which are provided by the exception object itself. You can also do the same thing with a general rescue clause:

begin
  raise "Hello I am a random runtime error"
rescue => e
  p e.message
  p e.backtrace
end
Finally if you have rescued an exception, but don’t want to handle it yourself (for whatever strange reason), calling raise within a rescue block with no parameters will allow you to re-raise the original exception that you have rescued rather than the normal behavior (i.e. raising a general runtime exception).


===============Creating Your Own Exceptions
Application Errors:
class MyCrazyError < StandardError
end

Enviornment Errors:
class MyCrazyException < Exception
end
 
raise MyCrazyException, "I am a crazy new exception"

========Ruby Exception List
The Ruby Exception Hierarchy

If you’re curious about the kinds of exceptions that Ruby has predefined for you, here is a list:

Exception
 NoMemoryError
 ScriptError
   LoadError
   NotImplementedError
   SyntaxError
 SignalException
   Interrupt
 StandardError
   ArgumentError
   IOError
     EOFError
   IndexError
   LocalJumpError
   NameError
     NoMethodError
   RangeError
     FloatDomainError
   RegexpError
   RuntimeError
   SecurityError
   SystemCallError
   SystemStackError
   ThreadError
   TypeError
   ZeroDivisionError
 SystemExit
 fatal
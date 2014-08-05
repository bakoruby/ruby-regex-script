#!/usr/bin/ruby

# http://rubylearning.com/satishtalim/ruby_regular_expressions.html
# http://www.tutorialspoint.com/ruby/ruby_regular_expressions.htm
# http://www.ruby-doc.org/core-2.1.1/Regexp.html
# http://www.ruby-doc.org/core-2.1.1/MatchData.html
# http://rubular.com/

def match_regex_index(question, string_to_match, match_string)
  begin
    puts question
    puts ""

    # get the next line
    line = gets

    # verify that this is valid regular expression
    line = nil unless line.match(/\/(.*)\//)

    # eval the line (This is using a sledgehammer on a nail)
    begin
      regex = eval(line)
    rescue SyntaxError, TypeError
    end

    # puts regex.inspect

    # try to match the newly created regex against the string
    match = regex.match(string_to_match) if regex

    if match && match[0] && match[0] == match_string
      success = true
      puts "Success! Your match was #{match}\n\n"
    else
      puts "\nSorry, try again. Your match was #{match.inspect}\n "
    end

  end while(success != true)
end

puts <<-EOS

-------------------------------
  Regular Expressions in Ruby"
-------------------------------

A regular expression is a special sequence of characters that helps you match or find other strings or sets of strings using a specialized syntax held in a pattern.

A regular expression literal is a pattern between slashes
/pattern/
EOS


match_regex_index("--> Create a regular expression to match exactly 'ruby'.", "ruby", "ruby")

puts <<-EOS

-------------------------------
  Regex object and Regular Expression options
-------------------------------
Using the // creates a Regexp object
//.class = #{//.class}

// can also have options.
/pattern/im"
Some common patterns are:
i - Ignore case when matching text
x - Ignores whitespace and allows comments in regular expressions

EOS


match_regex_index("--> Create a regular expression to match 'ruby' that isn't case sensitive.", "RuBy", "RuBy")

puts <<-EOS

-------------------------------
  Regex match method and match operator
-------------------------------

The simplest way to determine a match is to use the .match method.
It returns nil if no match otherise a MatchData object.

puts 'm1 = /Ruby/.match("The future is Ruby")'
#{m1 = /Ruby/.match("The future is Ruby")}
m1.class = #{m1.class}

You can also use a match operator ~= which returns nil if no match or the index of the first match.

'm2 = "The future is Ruby" =~ /Ruby/'
       --------------^---
m2 == #{m2 = "The future is Ruby" =~ /Ruby/}

Press Return
EOS

gets

puts <<-EOS

-------------------------------
      Literal Characters
-------------------------------

/a/ matches the character a
'ba' =~ /a/ = #{'ba' =~ /a/}
'b' =~ /a/ = #{('b' =~ /a/).inspect}

Special meaning characters such as ?.
These characters have to be escaped with \\
i.e. /\\?/ will match for the question mark

The special characters include ^, $, ? , ., /, \\, [, ], {, }, (, ), +, and *.

EOS

match_regex_index("--> Create a regular expression to match '[' in '[1,2,3]'", "[1,2,3]", "[")

puts <<-EOS

-------------------------------
 The wildcard character . (dot)
-------------------------------

A dot matches any character with the exception of a newline.
/./ matches any character but a newline
/.ing/ will match anything ending with ing
'laughing' =~ /.ing/ = #{('laughing' =~ /ing/)}
'running' =~ /.ing/ = #{('running' =~ /ing/)}
'inging' =~ /.ing/ = #{('inging' =~ /ing/)}

This can often overmatch because it is so general.

Press Return
EOS
gets

puts <<-EOS
-------------------------------
       Character classes
-------------------------------

Character classes are an explicit list of characters placed inside square brackets.

'rejected' =~ /[dr]ejected/ == #{'rejected' =~ /[dr]ejected/}

You can also specify a range of characters by using the dash -
/[A-Fa-f0-9]/ matches lower and upper hex values

By putting a caret ^ at the beginning of a character class you will perform a negative search"
'Run' =~ /[^A-Fa-f0-9]/ == #{('Run' =~ /[A-Fa-f0-9]/).inspect}

A character class will only match a single character.

Press Return
EOS

gets

puts <<-EOS

-------------------------------
 Repetition using quantifiers
-------------------------------

Every so far matches a single character. They can be followed by a repetition metacharacter to specify how many times they should occur.
* - Zero or more times
+ - One or more times
? - Zero or one times (optional)
{n} - Exactly n times
{n,} - n or more times
{,n} - or or less times
{m,n} - at least m times and at most m times

This is a greedy quantifier. It wants to find as many matches as possible
/<.+>/.match("<a><b>")  #=> #<MatchData "<a><b>">

This is a lazy quantifier. It will find the first one available because it uses the ?.
/<.+?>/.match("<a><b>") #=> #<MatchData "<a>">

Press Return
EOS

gets

puts <<-EOS

-------------------------------
Special Escape Sequences for common character classes
-------------------------------

[0-9] also is /\\d/
/\\w/ matches digits, alpha and underscore
/\\s/ matches whitespace (space, tab, newline)

These all have a negative form
/\\D/, /\\W/, /\\S/

/\\d/.match("123")  => #<MatchData "1">
/\\D/.match("123")  => nil

Press Return
EOS

gets

puts <<-EOS

-------------------------------
          Capturing
-------------------------------

Up until now we have just been finding matches. In order to capture text we must use parentheses ().

/[csh](..) [csh]\1 in/.match("The cat sat in the hat") => #<MatchData "cat sat in" 1:"at">
 -- [csh] - match c, s or h
 -- (..) - match 2 non newline characters
 -- [csh] - match c, s or h
 --  in - match a space and in

Parentheses also group the terms they enclose.
The pattern below matches a vowel followed by 2 word characters

/[aeiou]\w{2}/.match("Caenorhabditis elegans") #=> #<MatchData "aen">
 -- [aeiou] - any one vowel
 -- \w{2} - any 2 word characters

/(.*)/ will match any zero or more non-newline characters. Very greedy
/(.*)/.match("\n")  => #<MatchData "" 1:"">

/(.+)/ will match any 1 or more non-newline characters
/(.+)/.match("\n")  => nil

Press Return
EOS

gets

puts <<-EOS

-------------------------------
 Current Productionn Examples
-------------------------------

path =~ /\.(json|xml|js)$/
 -- match if the path ends with json, xml or js

answer =~ (/^(true|t|yes|y|1|on)$/i)
 -- match if answer is true, t, yes, y, 1 or on checking from the beginning of the line to the end of line

env["PATH_INFO"] =~ /^\/glusterfs\/(.+)$/
  -- match that it starts with /glusterfs/ and chan any number of characters after it

title =~ /\@\#\$\%/
  -- match that title has @#$& somewhere in the string

type_id.to_s.match(/^[0-9]/)
  -- match that type_id starts with a number

request.user_agent.match(/Firefox[\/\s][0-3][^\d][^\s]*/)
  -- matches it starts with FireFox/ and has a number of 0,1,2 or 3, followed by a non digit, followed by a or or more non space characters


EOS







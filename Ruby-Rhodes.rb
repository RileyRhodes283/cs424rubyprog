=begin
FileName: Ruby-Rhodes.rb
Author: Riley Rhodes
Professor: Mr. Delugach
Course: CS 424-02
Assignment Details: Create a program in ruby using two classes that
will take one file input of text and assign values to the classes
and output information to the screen
Program Instructions: Open command terminal, and cd to the path of this file, call 
ruby Ruby-Rhodes.rb and hit enter.
Beginning summary on my design: Two classes, one holds athletes and other is events, then 
the main deals with the file parseing and outputs
=end

=begin
Class: Athlete 
Variables: @playerId,@playerName,@eventsPresentId,@eventsPresentName
Functions present: printer(),getId(),getName(),setEvent(input),setEventName(input),
getEventPresentName(),getPlayerEvent(),getEvent()
=end
class Athlete
    def initialize(id, name) #constructor
        @playerId = id
        @playerName = name
        @eventsPresentId = ""
        @eventsPresentName = Array.new
    end 
    def printer() # function to print to screen
        puts "\nThe player ID number is #@playerId\n"
        puts "The player's name is #@playerName\n"
        puts "The player is at this event #{getEvent()}\n"
    end
    def getId()# funtion that returns playerId
        return @playerId
    end
    def getName() # funtion that returns playerName
        return @playerName
    end
    def setEvent(input) # funtion that sets events that athlete is present at 
        @eventsPresentId = @eventsPresentId + input + " "
    end
    def setEventName(input) # funtion that sets the name of events present at
        @eventsPresentName.push(input)
    end
    def getEventPresentName() # function that returns events names 
        return @eventsPresentName
    end
    def getPlayerEvent() # funtion that returns events present Id
        return @eventsPresentId
    end
    def getEvent() # fuction that returns a string of events they are at
        local = ""
        for event in @eventsPresentName do
            local = local +  event + ", "
        end
        local = local.slice(0,local.length()-2 )
        local = local + "."
        return local
    end
end
=begin
Class: Events 
Variables: @playerId,@playerName,@eventsPresentId,@eventsPresentName
Functions present: printer(),getId(),getName(),getPlayers(), addPlayer()
=end
class Events
    def initialize(id, name) #constructor
        @eventId = id
        @eventName = name
        @playersPresent = Array.new
    end 
    def printer() # function that prints to screen 
        puts "\nThe event ID number is #@eventId\n"
        puts "The event name is #@eventName\n"
        puts "The players present are #{getPlayers()}"
    end
    def getId() # function that gets events ID
        return @eventId
    end
    def getName() # function that gets events name
        return @eventName
    end
    def getPlayers() # # function that returns a string of all players at an event
        local = ""
        for players in @playersPresent do
            local = local +  players + ", "
        end
        local = local.slice(0,local.length()-2 )
        local = local + "."
        return local
    end
    def addPlayer(input) #function that pushes to an array of players present
        @playersPresent.push(input)
    end
end
=begin
This is the beginning of the "main" for this program
=end
counter = 0 # initial counter 
playerHandler = Array.new 
eventHandler = Array.new
lineHolder = Array.new

file = File.open("register.txt") # open file with File.open
a = file.readlines.map() # reads line by line 
a.each do |num| # num is each line 
    myarray = num.split(nil, 2) # split the line into two arrays 
    if myarray == [""] # if it is a space go to next iteration and change counter for switch statement
        counter+=1
        next
    end
    myarray[1] = myarray[1].to_s.chomp() # take away newline from the last element 
    case counter  # switch statement to see what block we are in of file reading 
    when 0 # case 0: Athletes 
        item = Athlete.new(myarray[0],myarray[1])
        playerHandler.push(item)
    when 1 # case 1: Events 
        item = Events.new(myarray[0],myarray[1])
        eventHandler.push(item)
    when 2 # case 2: checker of events 
        lineHolder.push("#{myarray[0] +","+ myarray[1]}")  #push lineHolder such that we can pair later 
        found = false # initial check to see if something is found
        playerHandler.map{|foo| # iterate over all the players and see if this id is present
        if (myarray[0] == foo.getId)
            puts "\nPlayer ID #{myarray[0]} found"
            found = true 
            break #break the iteration of events cause it was found
        end
        }
        if (found == false) # if not found pop element out of line holder, cause line is incorrect
            puts "Player ID #{myarray[0]} wasn't found"
            puts "String #{myarray} is deleted from events/player list"
            lineHolder.pop() # if its not found at all pop last item to prevent assigning error
        end
        found = false
        eventHandler.map{|bar|# iterate over all the events and see if this id is present
        if(myarray[1] == bar.getId) 
            puts "Event ID #{myarray[1]} found\n"
            found = true
            break #break the iteration of events cause it was found
        end
        }
        if (found == false)# if not found pop element out of line holder, cause line is incorrect
            puts "Event ID #{myarray[1]} wasn't found"
            puts "String #{myarray} is deleted from events/player list"
            lineHolder.pop() # if its not found at all pop last item to prevent assigning error
        end
    end
end
lineHolder.each do |m|  # iterate over lineholders lines to assign the players to events and vise versa
    playerNum,eventNum = m.split(",", 2) 

    playerHandler.each do |finder|# loop over players to set events 
        if(finder.getId == playerNum) # if found set the event into an array
            finder.setEvent(eventNum)
            eventHandler.each do |looker| # loop over events to set players 
                finderA = finder.getPlayerEvent.split(" ") # loop over all events they are present at to link names
                impo = finderA.pop()
                if looker.getId == impo
                finder.setEventName(looker.getName) #if found set event name
                looker.addPlayer(finder.getName) #if found set players ID
                break
                end
            end
        end
    end



end
playerHandler.each do |b| # loop over players objects to print to screen
    b.printer
end
eventHandler.each do |c| # loop over events objects to print to screen
    c.printer
end

=begin
This is the end of the "main" for this program.



Lessons Learned: 
This was a rather intersting coding assignment to learn ruby. 
1st) Took some time to understand the .map functionality to make an iteratable array. 
2nd) Using arrays as holders to make iterations faster over the objects.

Impressions: This is a nice langauge, and is understanble why this is typically used in web development.
Overall, I could see this language being useful in certain use cases. 
=end

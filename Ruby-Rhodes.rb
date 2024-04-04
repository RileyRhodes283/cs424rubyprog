=begin
This is another
way of writing 
comments in a 
block fashion
=end


class Athlete
    def initialize(id, name)
        @playerId = id
        @playerName = name
        @eventsPresentId = ""
        @eventsPresentName = Array.new
    end 
    def printer()
        puts "\nThe player ID number is #@playerId\n"
        puts "The player's name is #@playerName\n"
        puts "The player is at this event #{getEvent()}\n"
    end
    def getId()
        return @playerId
    end
    def getName()
        return @playerName
    end
    def setEvent(input)
        @eventsPresentId = @eventsPresentId + input + " "
    end
    def setEventName(input)
        @eventsPresentName.push(input)
    end
    def getEventPresentName()
        return @eventsPresentName
    end
    def getPlayerEvent()
        return @eventsPresentId
    end
    def getEvent()
        local = ""
        for event in @eventsPresentName do
            local = local +  event + ", "
        end
        local = local.slice(0,local.length()-2 )
        local = local + "."
        return local
    end
end

class Events
    def initialize(id, name)
        @eventId = id
        @eventName = name
        @playersPresent = Array.new
    end 
    def printer()
        puts "\nThe event ID number is #@eventId\n"
        puts "The event name is #@eventName\n"
        puts "The players present are #{getPlayers()}"
    end
    def getId()
        return @eventId
    end
    def getName()
        return @eventName
    end
    def getPlayers()
        local = ""
        for players in @playersPresent do
            local = local +  players + ", "
        end
        local = local.slice(0,local.length()-2 )
        local = local + "."
        return local
    end
    def addPlayer(input)
        @playersPresent.push(input)
    end
end

counter = 0
playerHandler = Array.new
eventHandler = Array.new
v = Array.new
file = File.open("register.txt")
a = file.readlines.map()
a.each do |num|
    myarray = num.split(nil, 2)
    if myarray == [""]
        counter+=1
        next
    end
    myarray[1] = myarray[1].to_s.chomp()
    case counter 
    when 0
        item = Athlete.new(myarray[0],myarray[1])
        playerHandler.push(item)
    when 1
        item = Events.new(myarray[0],myarray[1])
        eventHandler.push(item)
    when 2
        v.push("#{myarray[0] +","+ myarray[1]}") 
        found = false
        playerHandler.map{|foo|
        if (myarray[0] == foo.getId)
            puts "\nPlayer ID #{myarray[0]} found"
            found = true
            break 
        end
        }
        if (found == false)
            puts "Player ID #{myarray[0]} wasn't found"
            puts "String #{myarray} is deleted from events/player list}"
            v.pop() # if its not found at all pop last item to prevent assigning error
        end
        found = false
        eventHandler.map{|bar|
        if(myarray[1] == bar.getId)
            puts "Event ID #{myarray[1]} found\n"
            found = true
            break
        end
        }
        if (found == false)
            puts "Event ID #{myarray[1]} wasn't found"
            puts "String #{myarray} is deleted from events/player list}"
            v.pop() # if its not found at all pop last item to prevent assigning error
        end
    end
end
v.each do |m| 
    playerNum,eventNum = m.split(",", 2)

    playerHandler.each do |finder|
        if(finder.getId == playerNum)
            finder.setEvent(eventNum)
            eventHandler.each do |looker|
                finderA = finder.getPlayerEvent.split(" ")
                impo = finderA.pop()
                if looker.getId == impo
                finder.setEventName(looker.getName)
                looker.addPlayer(finder.getName) 
                break
                end
            end
        end
    end



end
playerHandler.each do |b|
    b.printer
end
eventHandler.each do |c|
    c.printer
end

import UIKit

print(generateMadLib(adjective1: "cringe", noun1: "frog", verbEndingIn_ing: "texting", adjective2: "fast", animal1: "shark", verb2: "smile", place1: "Mordur", pluralNoun1: "chicken nuggets", adjective3: "attractive", exclamation: "crumpets"))

func generateMadLib(adjective1: String,
                    noun1: String,
                    verbEndingIn_ing: String,
                    adjective2: String,
                    animal1: String,
                    verb2: String,
                    place1: String,
                    pluralNoun1: String,
                    adjective3: String,
                    exclamation: String) -> String {
    let randomStorySelection = Int.random(in: 1...3)
    let randomAdjectiveOrder1 = switch Int.random(in: 1...3) {
    case 1:
        adjective1
    case 2:
        adjective2
    case 3:
        adjective3
    default:
        adjective1
    }
    let randomAdjectiveOrder2 = switch Int.random(in: 1...3) {
    case 1:
        randomAdjectiveOrder1 == adjective1 ? adjective2 : adjective1
    case 2:
        randomAdjectiveOrder1 == adjective2 ? adjective3 : adjective2
    case 3:
        randomAdjectiveOrder1 == adjective3 ? adjective1 : adjective3
    default:
        adjective1
    }
    let randomAdjectiveOrder3 = switch Int.random(in: 1...3) {
    case 1:
        randomAdjectiveOrder1 == adjective1 || randomAdjectiveOrder2 == adjective1 ? adjective2 : adjective1
    case 2:
        randomAdjectiveOrder1 == adjective2 || randomAdjectiveOrder2 == adjective2 ? adjective3 : adjective2
    case 3:
        randomAdjectiveOrder1 == adjective3 || randomAdjectiveOrder2 == adjective3 ? adjective1 : adjective3
    default:
        adjective1
    }
    
    if adjective1.isEmpty || verbEndingIn_ing.isEmpty || adjective2.isEmpty || animal1.isEmpty || verb2.isEmpty || place1.isEmpty || pluralNoun1.isEmpty || adjective3.isEmpty || exclamation.isEmpty {
        return "Invalid Input"
    } else {
        switch randomStorySelection {
        case 1:
            return """
            Today was a \(randomAdjectiveOrder1) day. I woke up and immediately saw a \(noun1) \(verbEndingIn_ing) in my room. 
            I felt \(randomAdjectiveOrder2), but then a \(animal1) told me to \(verb2) right away.
            Before I knew it, I was at \(place1), surrounded by \(pluralNoun1) that smelled extremely \(randomAdjectiveOrder3). 
            I screamed, “\(exclamation)!” and then realized it was all just a dream… or was it?
            """
        case 2:
            return """
            It started as a \(randomAdjectiveOrder1) morning when I tripped over a \(noun1) \(verbEndingIn_ing) on 
            the sidewalk. 
            Feeling \(randomAdjectiveOrder2), I looked up and saw a \(animal1) trying to \(verb2) nearby.
            Suddenly, I was transported to \(place1), where \(pluralNoun1) were dancing in a \(randomAdjectiveOrder3) way.
            I couldn’t help but shout, \(exclamation)!” as the adventure began.
            """
        case 3:
            return """
            Yesterday turned into a \(randomAdjectiveOrder1) experience when I opened a \(noun1) and found it \(verbEndingIn_ing) uncontrollably. 
            I felt \(randomAdjectiveOrder2) and stepped back, but then a \(animal1) tried to \(verb2) my shoe.
            I ran all the way to \(place1), where \(pluralNoun1) were making a \(randomAdjectiveOrder3) mess. I yelled,
            “\(exclamation)!” and slammed the door shut.
            """
        default:
            return ""
        }
    }
}

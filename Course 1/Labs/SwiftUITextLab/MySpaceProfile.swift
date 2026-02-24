//
//  MySpaceProfile.swift
//  SwiftUITextLab
//
//  Created by Jane Madsen on 9/10/25.
//

import SwiftUI

/*
 ## Instructions:
 Your goal is to create an app that will serve as a social media profile. Use Text view modifiers to arrange and style your profile to reflect your unique style.
 
 Since this assignment will require you to choose custom fonts, you may want to open the Font Book app installed on your Mac, where you can view a list of the fonts available on Mac and iOS by default.
 
 If you would like to change the background color of each of these views, you can do so by changing the colors listed in each #Preview macro at the bottom of the page.
 
 1. Create three structs that conform to View: ProfileView, TopFiveFriendsView, and BlogPostView. This will fix the errors
 2. To see a preview of how each view will look in the app, make sure you have opened your canvas (Option + Command + Return). You can view each struct you've created by clicking on the tabs at the top of the canvas.
 3. Create a profile view with Text elements for each of the following items: Username, Real Name, Home City, and Bio. Style each of them appropriately with custom fonts, font sizes, and colors for each. Feel free to add any additional modifiers as well.
 4. Create a TopFiveFriends view with a list of your friends, ranked in order of favorite to least favorite. (Don't worry, we won't tell them). Use a different font and color for each person, and include an Emoji to represent each one as well.
 5. Create a BlogPostView. Write a long blog post. Give your blog post a title, a date posted, a body, and a display of number of likes and comments. Once again, style each individually with fonts, font sizes, and colors, and any other modifiers you would like.
 6. Try running the app. You should see all three views embedded in Tabs (the code for this is in SwiftUITextLabApp.swift). You may need to adjust the style slightly to accommodate the Tab Bar at the bottom of the screen.
 
 ## Black Diamond
 
 7. Add one or more Image views to each page.
 8. Use Stack views to arrange your content more dynamically.
 
 ## Rubric
 
 - App has a profile view with Username, Real Name, Home City, and Bio, appropriately filled out and styled.
 - App has a Top Five Friends screen with emoji, fonts, and colors for each friend.
 - App has a blog post view with a title, a date posted, a body, and a number of likes and comments. All are styled, sized, and colored appropriately.
 */
struct MainView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
            TopFiveFriendsView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Friends")
                    }
                }
            BlogPostView()
                .tabItem {
                    VStack {
                        Image(systemName: "document.fill")
                        Text("Blog")
                    }
                }
        }
    }
}
struct ProfileView: View {
    var body: some View {
        VStack {
            Text("miles_norris1")
                .font(.largeTitle)
                .bold()
            Text("Miles Norris")
                .font(.custom("papyrus", size: 30))
                .foregroundStyle(Color.red)
            Text("Lehi, UT")
                .font(.title2)
                .italic()
            Text("I am 17, and I live in lehi with my 6 siblings and parents.")
                .underline()
        }
    }
}
struct TopFiveFriendsView: View {
    var body: some View {
        VStack {
            Text("Asher 🐕")
                .foregroundStyle(Color.red)
                .font(.custom("AcademyEngravedLetPlain", size: 30))
            Text("Christian 🍗")
                .foregroundStyle(Color.green)
                .font(.custom("Avenir-Black", size: 30))
            Text("Calan ♠️")
                .foregroundStyle(Color.orange)
                .font(.custom("AvenirNextCondensed-Italic", size: 30))
            Text("Charlie 🫥")
                .foregroundStyle(Color.blue)
                .font(.custom("Baskerville-BoldItalic", size: 30))
            Text("Braden 😡")
                .foregroundStyle(Color.yellow)
                .font(.custom("BodoniSvtyTwoITCTT-Bookita", size: 30))
        }
    }
}
struct BlogPostView: View {
    var body: some View {
        VStack {
            Text("Title: In Praise of Quiet Progress")
                .font(.largeTitle)
                .bold()
            ScrollView {
                Text("Some days don’t look like progress. They’re slow, ordinary, and easy to overlook—coffee that cools a little too fast, a walk with no destination, a single sentence rewritten until it finally feels right. I used to fight those days, stuffing them with busywork to prove I was moving. Now I try to let them be what they are: space to notice, to tinker, to breathe. \n The surprising thing is how much the big days depend on the quiet ones. Ideas connect more easily after a gentle morning. Patience lasts longer when I’m not sprinting by default. Goals still matter, but they’re less of a treadmill and more of a landscape—ridgelines and valleys, each necessary in its own way. \n If today is slow, let it be slow. Do one thing with care. Call it enough. The highlight reels are built in moments like this, even if they don’t look like it yet.")
                    .padding()
                    .font(.custom("AcademyEngravedLetPlain", size: 30))
            }
            HStack {
                Text("2/20/2026")
                    .italic()
                Spacer()
                Text("Likes: 20")
                    .bold()
                    .foregroundStyle(Color.yellow)
                Text("Comments: 8")
                    .bold()
                    .foregroundStyle(Color.blue)
            }
            .padding()
        }
    }
}
#Preview("MainView") {
    MainView()
        .background(.white)
}
#Preview("ProfileView") {
    ProfileView()
        .background(.white)
}

#Preview("TopFiveFriendsView") {
    TopFiveFriendsView()
        .background(.white)
}

#Preview("BlogPostView") {
    BlogPostView()
        .background(.white)
}

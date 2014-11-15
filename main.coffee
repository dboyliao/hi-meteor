# 在全域如果沒有 @，就只有 Server 看得到~ 
@testPosts = [{text: "Hi Metoer"},
              {text: "Meteor is great!", \
              author: "Dboy"},
              {text: "Meteor is the best!"}]

@Posts = new Meteor.Collection "posts"

Router.configure
    layoutTemplate: "layout"

Meteor.startup ->
    Route.map ->
        @route "index",
            path: "/"
            template:"posts"

reload = true
if Meteor.isClient
# Children's helpers will be export to parent's 
# helpers
    Template.posts.helpers
        postsArray: ->
            Posts.find {}, {sort:{createAt:-1}}
        user: ->
            Meteor.user()

    Template.posts.events
        "change input#insertPost": (e, t) ->
            e.stopPropagation()
            text = $("input#insertPost").val()

            Meteor.call "insertPost", text, (err, data) ->
                $("#insertPost").val("")
                if not err
                    console.log "data:"
                    console.log data
                else
                    console.log "error:"
                    console.log err


    Template.self.helpers
        testObj:
            name: "Dboy"
            birth: "1987/03/29"
            height: 172
            male: true

if Meteor.isServer
    Meteor.methods
        "insertPost": (text) ->
            user = Meteor.user()

            if user
                username = user.profile.name
                userId = user._id
            else
                # username = "Anonymous"
                # userId = "None"
                throw new Meteor.Error(401, "Login First to post!")
            data = 
                text: text
                author: username
                userId: userId
                createAt: new Date()
            Posts.insert data

    # if Posts.find().count() is 0
    #     Posts.insert post for post in testPosts


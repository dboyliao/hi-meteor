if Meteor.isClient
# Children's helpers will be export to parent's 
# helpers
    Template.posts.helpers
        testVar1: "test post 1"
        testVar2: "test post 2"
        testVar3: true
        testVar4: 3.1415926
        testVar5: new Date()
        testArray:[{text: "Hi Metoer"},
                   {text: "Meteor is great!", \
                   author: "Dboy"},
                   {text: "Meteor is the best!"}]

    Template.self.helpers
        testObj:
            name: "Dboy"
            birth: "1987/03/29"
            height: 172
            male: true
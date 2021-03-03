user_1 = User.create(username: "Andy", email: "andy22@mail.com", password: "HandyAndy", museum: "DeYoung", position: "curator")
user_2 = User.create(username: "Delilah", email: "delilah@email.net", password: "HeyThereDelilah", museum: "Smithsonian", position: "conservator")

piece_1 = Piece.create(title: "Gumball Machines", creator: "Wayne", medium: "oil on canvas", dimensions: "18 x 24")
piece_2 = Piece.create(title: "Mona Lisa", creator: "Leonardo", medium: "oil on canvas", dimensions: "18in x 24in")
piece_3 = Piece.create(title: "David", creator: "Michelangelo", medium: "white marble", dimensions: "2ft x 6ft")

user_1.pieces << piece_1 
user_2.pieces << piece_2
user_2.pieces << piece_3  
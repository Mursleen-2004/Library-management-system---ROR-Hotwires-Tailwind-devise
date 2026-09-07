puts "Seeding database..."

admin = User.find_or_create_by!(email: "admin@library.com") do |u|
  u.name = "Admin User"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
end

member = User.find_or_create_by!(email: "member@library.com") do |u|
  u.name = "Jane Reader"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :member
end

categories = ["Fiction", "Science Fiction", "Fantasy", "Non-Fiction", "History", "Biography"].map do |name|
  Category.find_or_create_by!(name: name)
end

authors_data = [
  { name: "George Orwell", bio: "English novelist and essayist, best known for 1984 and Animal Farm." },
  { name: "J.R.R. Tolkien", bio: "English writer and philologist, author of The Lord of the Rings." },
  { name: "Isaac Asimov", bio: "American writer and professor of biochemistry, known for science fiction works." },
  { name: "Yuval Noah Harari", bio: "Israeli historian and author of Sapiens and Homo Deus." },
  { name: "Agatha Christie", bio: "English writer known for her detective novels." }
]

authors = authors_data.map { |data| Author.find_or_create_by!(name: data[:name]) { |a| a.bio = data[:bio] } }

books_data = [
  { title: "1984", author: "George Orwell", category: "Fiction", year: 1949, copies: 3 },
  { title: "Animal Farm", author: "George Orwell", category: "Fiction", year: 1945, copies: 2 },
  { title: "The Hobbit", author: "J.R.R. Tolkien", category: "Fantasy", year: 1937, copies: 4 },
  { title: "The Lord of the Rings", author: "J.R.R. Tolkien", category: "Fantasy", year: 1954, copies: 2 },
  { title: "Foundation", author: "Isaac Asimov", category: "Science Fiction", year: 1951, copies: 3 },
  { title: "I, Robot", author: "Isaac Asimov", category: "Science Fiction", year: 1950, copies: 2 },
  { title: "Sapiens", author: "Yuval Noah Harari", category: "Non-Fiction", year: 2011, copies: 5 },
  { title: "Homo Deus", author: "Yuval Noah Harari", category: "History", year: 2015, copies: 2 },
  { title: "Murder on the Orient Express", author: "Agatha Christie", category: "Fiction", year: 1934, copies: 3 }
]

books_data.each do |data|
  author = authors.find { |a| a.name == data[:author] }
  category = categories.find { |c| c.name == data[:category] }

  Book.find_or_create_by!(title: data[:title]) do |b|
    b.author = author
    b.category = category
    b.published_year = data[:year]
    b.total_copies = data[:copies]
    b.available_copies = data[:copies]
    b.description = "A notable work by #{author.name}."
  end
end

puts "Seed complete."
puts "Admin login: admin@library.com / password123"
puts "Member login: member@library.com / password123"

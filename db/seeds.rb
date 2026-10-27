SEEDS_DIR = Rails.root.join("db/seeds")
COVERS_DIR = Rails.root.join("public/autoupload/post_covers")

def seed
  clean_uploads_folder
  create_admin
  create_rubrics
  create_categories
  create_posts
end

def clean_uploads_folder
  FileUtils.rm_rf(Rails.root.join("public/uploads"))
  puts "Uploads folder just cleaned"
end

# Пароль только из переменной окружения, в коде его нет
def create_admin
  user = User.create!(email: "admin@example.com", password: ENV.fetch("ADMIN_PASSWORD"), role: "admin")
  puts "User with id #{user.id} just created"
end

def create_rubrics
  load_seed_file("rubrics").each do |data|
    rubric = Rubric.create!(data)
    puts "Rubric with id #{rubric.id} just created"
  end
end

def create_categories
  load_seed_file("categories").each do |data|
    category = Category.create!(data)
    puts "Category with id #{category.id} just created"
  end
end

def create_posts
  load_seed_file("posts").each do |data|
    post = Post.create!(
      rubric: Rubric.find_by!(slug: data["rubric"]),
      category: data["category"] && Category.find_by!(slug: data["category"]),
      title: data["title"],
      slug: data["slug"],
      lead: data["lead"],
      status: data["status"],
      published_at: data["published_at"],
      body: read_post_body(data["slug"]),
      cover: data["cover"] && File.open(COVERS_DIR.join(data["cover"]))
    )
    puts "Post with id #{post.id} just created"
  end
end

def load_seed_file(name)
  YAML.load_file(SEEDS_DIR.join("#{name}.yml"))
end

def read_post_body(slug)
  path = SEEDS_DIR.join("posts", "#{slug}.md")
  raise "Нет текста для поста «#{slug}»: создайте файл db/seeds/posts/#{slug}.md" unless path.exist?

  path.read
end

seed

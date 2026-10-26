# Посевные данные для показа сервиса «с нуля»:
#
#   ADMIN_PASSWORD=придумайте-пароль bin/rails db:reset
#
# db:reset пересоздаёт базу по db/schema.rb и запускает этот файл.
# Данные лежат отдельно от кода:
#   db/seeds/rubrics.yml, categories.yml, posts.yml — метаданные;
#   db/seeds/posts/<slug>.md — текст каждого поста в Markdown;
#   public/autoupload/post_covers — картинки для обложек.

SEEDS_DIR = Rails.root.join("db/seeds")
COVERS_DIR = Rails.root.join("public/autoupload/post_covers")

def seed
  check_before_seed
  clean_uploads_folder

  # Если что-то пойдёт не так (например, нет текста поста), база останется пустой
  ActiveRecord::Base.transaction do
    create_admin
    create_rubrics
    create_categories
    create_posts
  end
end

# Проверяем всё до того, как что-то менять.
# Записи создаются через create!, поэтому сиды запускаются только на пустой базе
def check_before_seed
  if User.exists? || Rubric.exists? || Category.exists? || Post.exists?
    raise "База не пустая. Чтобы заполнить её с нуля, запустите: ADMIN_PASSWORD=... bin/rails db:reset"
  end

  if ENV["ADMIN_PASSWORD"].blank?
    raise "Не задан пароль администратора. Запустите: ADMIN_PASSWORD=... bin/rails db:reset"
  end
end

# Обложки старых постов больше не нужны: база создаётся заново
def clean_uploads_folder
  FileUtils.rm_rf(Rails.root.join("public/uploads"))
  puts "Uploads folder just cleaned"
end

# Пароль только из переменной окружения, в коде его нет
def create_admin
  user = User.create!(
    email: ENV.fetch("ADMIN_EMAIL", "admin@example.com"),
    password: ENV.fetch("ADMIN_PASSWORD"),
    role: "admin"
  )
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
      cover: data["cover"] && open_cover(data["cover"])
    )
    puts "Post with id #{post.id} just created"
  end
end

def load_seed_file(name)
  YAML.load_file(SEEDS_DIR.join("#{name}.yml"))
end

# Текст поста лежит отдельно от метаданных. Без него сиды падают, а не пропускают пост
def read_post_body(slug)
  path = SEEDS_DIR.join("posts", "#{slug}.md")
  raise "Нет текста для поста «#{slug}»: создайте файл db/seeds/posts/#{slug}.md" unless path.exist?

  path.read
end

def open_cover(file_name)
  path = COVERS_DIR.join(file_name)
  raise "Нет картинки для обложки: public/autoupload/post_covers/#{file_name}" unless path.exist?

  File.open(path)
end

seed

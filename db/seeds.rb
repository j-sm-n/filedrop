# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  2.times do
    user = User.create( name: "#{Faker::Name.name}",
                        email: "#{Faker::Internet.email}",
                        role: 0,
                        sms_number: "#{Faker::PhoneNumber.cell_phone}",
                        password_digest: "#{Faker::Internet.password(32)}",
                        authy_id: "#{Faker::Number.number(10)}",
                        created_at: "#{Faker::Date.between(10.days.ago, 8.days.ago)}",
                        updated_at: "#{Faker::Date.between(8.days.ago, 6.days.ago)}",
                        status: 0
                      )
    2.times do
      folder = Folder.create( name:  "#{Faker::Name.name}",
                              user_id: user.id,
                              created_at:  "#{Faker::Date.between(6.days.ago, 4.days.ago)}",
                              updated_at:  "#{Faker::Date.between(4.days.ago, 2.days.ago)}",
                              permission_level: [0,1].sample
                            )
      2.times do
        document = Document.create( filename: Faker::File.file_name,
                                    content_type: Faker::Lorem.paragraph,
                                    user_id: user.id,
                                    url: Faker::File.file_name('path/to')
                                  )
        containable_folder = Folder.create( name:  "#{Faker::Name.name}",
                                            user_id: user.id,
                                            created_at:  "#{Faker::Date.between(6.days.ago, 4.days.ago)}",
                                            updated_at:  "#{Faker::Date.between(4.days.ago, 2.days.ago)}",
                                            permission_level: [0,1].sample
                                          )
        containers = Container.create(  folder_id: folder.id,
                                        containable_id: document.id,
                                        created_at:  "#{Faker::Date.between(6.days.ago, 4.days.ago)}",
                                        updated_at:  "#{Faker::Date.between(4.days.ago, 2.days.ago)}"
                                      )
        containers = Container.create(  folder_id: folder.id,
                                        containable_id: containable_folder.id,
                                        created_at:  "#{Faker::Date.between(6.days.ago, 4.days.ago)}",
                                        updated_at:  "#{Faker::Date.between(4.days.ago, 2.days.ago)}"
                                      )
      end
    end
  end

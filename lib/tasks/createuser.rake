namespace :user do
    #creating a user by taking user email id and password as input
    task :createuser => :environment do
        print('Enter Email id of user: ')
        email = STDIN.gets.chomp
        print('Enter Password : ')
        password = STDIN.gets.chomp
    
        user = User.new(email: email, password: password)
        if user.save
            puts ('User created successfully')
        else
            puts('Cannot create a new user:')
            user.errors.full_messages.each do |message|
            puts(" * #{message}")
            end
        end
    end
end
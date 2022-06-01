

  If you have problems with the bundler version, run:

    gem install bundler

    bundle install

  If you have errors with libv8 on bundle update, run these commands:

    gem install libv8 -v '3.16.14.19' -- --with-system-v8

    gem install therubyracer -v '0.12.3' -- --with-system-v8

    bundle config build.libv8 --with-system-v8
    
    bundle config build.therubyracer --with-system-v8

    bundle install


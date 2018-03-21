'Cyfosodwr' is Welsh for asslember. As in word assembler.

This simple web service accepts some letters and returns the valid words those letters can form.

start it like this:
```sh
bundle exec rackup
```

call it like this
```sh
curl http://localhost:9292/words.json\?letters=BRIDGES
```

Still working out the details on deploying to nginx via unicorn, but that's what unicorn.rb file is for.


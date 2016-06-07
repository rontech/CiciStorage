[![Build Status](https://travis-ci.org/rontech/CiciStorage.svg?branch=master)](https://travis-ci.org/rontech/CiciStorage)[![Coverage Status](https://coveralls.io/repos/github/rontech/CiciStorage/badge.svg?branch=master)](https://coveralls.io/github/rontech/CiciStorage?branch=master)

## About 

CiciStorage provides storage through REST interface.You can contruct your own online web
sotrage service instead of Amazon S3 and other charged storage services.

## Background storage

We support google drive now, and will support the background storages below in the coming days:
- MongoDB
- Redis
- RDBMS

## Deploy to heroku

Follow the steps here and construct your own online web storage service:

1.Clone this repository to your computer

    $ git clone git@github.com:rontech/CiciStorage.git

2.Create your app through the command here

    $ heroku create

3.Use the sendgrid mail service

    $ heroku addons:add sendgrid:starter

4.Authorize your storage service

As for google drive,please refer to the site:[Authorizing Your App](https://developers.google.com/drive/v2/web/about-auth#why_use_google_for_authentication).
Update the concerned items in the google_drive.json file located at config/:
- client_id
- client_secret
- refresh_token

then commit the change to the local git repository.

5.Push to heroku 

    $ git push herou master

6.Migrate your database

    $ heroku run rake db:migrate  


## License

CiciStorage is **licensed** under the **[MIT License]**. The terms of the license are as follows:

    The MIT License (MIT)

    Copyright (c) 2016 Rontech Co., Ltd.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  
  [MIT License]: https://github.com/jenkinsci/jenkins/raw/master/LICENSE.txt

# jenathon
repository for the jenathon

## prerequisits
* coreos, any other linux that supports docker, Win 10
* docker, docker-compose
* docker already integrated in coreos
* for Windows 10 use the powershell and docker Win10 app (find here https://docs.docker.com/docker-for-windows/install/)

## getting started
* getting the sources
```
$ git clone https://github.com/agrohmann/jenathon.git
```
* build the images
```
$ cd ../jenathon/src
$ docker-compose build
```
* start container from images (if you using Win 10, you probably have to remove the volumes entries from the docker-compose files, or make a version 2 dockerfile see also [here](http://stackoverflow.com/questions/40109596/docker-mariadb-mysql-startup-fails-on-windows-host) )
```
$ docker-compose up -d
```
* check if the containers are running
```
$ docker ps
```
* build the database from rails container
```
$ docker exec -ti jenathon-production /bin/bash
$ rake db:create
$ rake db:migrate
$ exit
```
* check your browser at [http://localhost/](http://localhost/)
* do some administration stuff at [http://localhost/admin](http://localhost/admin)
* after changing code you should execute
```
$ cd ../jenathon/src
$ docker-compose stop
$ docker-compose rm -f
$ git pull
$ rm -f jenathon_rails/Gemfile.lock
$ docker-compose build
$ docker-compose up -d
$ docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```
(if you disable volumes in Win 10, prepare of loosing the database content)


## hands on
* look [for some examples](https://apneadiving.github.io/)
* to add own data use following ( [see also here](http://guides.rubyonrails.org/command_line.html#rails-generate) )
```
$ docker exec -ti jenathon-production /bin/bash
$ rails generate scaffold Example attr1:string attr2:integer
$ rake db:migrate
```

* to prepare the data for the app change following file ..\jenathon\src\jenathon_rails\app\controllers\static_pages_controller.rb
```ruby
def home
  # TODO: add more own models here to display in the map
  @users = User.all
  # TODO: build your hash for custom map content here
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
    marker.infowindow user.description
    unless user.logo_url.blank?
      marker.picture({
        "url" => user.logo_url,
        "width" => 32,
        "height" => 32
      })
    end
  end
end
```
* check whats possible in [google maps](https://developers.google.com/maps/documentation/javascript/tutorial)
* get your google map api key [here](https://developers.google.com/maps/documentation/javascript/get-api-key?hl=de#key)


* to change the javascript code in the template itselfs change following file ..\jenathon\src\jenathon_rails\app\views\static_pages\home.html.erb
```html
<script src="//maps.google.com/maps/api/js?key=[AD_YOUR_KEY_HERE]"></script>
<script src="//cdn.rawgit.com/mahnunchik/markerclustererplus/master/dist/markerclusterer.min.js"></script>
<script src='//cdn.rawgit.com/printercu/google-maps-utility-library-v3-read-only/master/infobox/src/infobox_packed.js' type='text/javascript'></script> <!-- only if you need custom infoboxes -->
...
<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>

<script type="text/javascript">
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(<%=raw @hash.to_json %>);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
</script>
```
* add icons for the map here /jenathon/src/jenathon_rails/public/icons, note that they have to have the format 32x32
* the [docker image](https://hub.docker.com/r/agrohmann/ruby_nodejs/) that is used (its only ruby with installed nodejs)

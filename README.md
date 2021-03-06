A very alpha munkiserver package mirror application.

You'd be interested in using this if you need on-site mirrors of your package repository, while maintaining an off-site munkiserver.

## Getting started ##

### Installing the app ###

```
cd where/you/want/the/app
git clone git://github.com/jnraine/package_mirror.git
```

### Configuring the app ###

Edit the settings file found at config/settings.yaml.  You'll need to specify a **path to the packages** and the **hostname** of your munkiserver.  It'll look something like this:

```
---
master_hostname: http://localhost:3000
packages_dir: !ruby/object:Pathname 
  path: /Users/jnraine/projects/munkiserver/packages
```

Be sure to leave the !ruby/object:Pathname there.

### Syncing your packages ###

Setup rsync on your munkiserver, configured to sync all the packages from your munkiserver to your package mirror to the specified in your settings.yaml.

### Starting the server ###

```
cd path/to/your/app
rails s
```

This will start it into development mode.  After testing it out, it's probably be a good idea to setup [Passenger](http://www.modrails.com/) or [Unicorn](http://unicorn.bogomips.org/) with Apache or Nginx.  This will offload the sending of the file to a webserver that is good at it.

### Configuring your clients ###

In order for your client computers to use your package mirror, you'll need to specify the URL of your package mirror in ManagedInstalls.plist under the PackageURL path.  You can find more [details on that key here](http://code.google.com/p/munki/wiki/configuration).
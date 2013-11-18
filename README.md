Vagrant project to create the Réseau libre's build VM
=====================================================

Requirements
------------

* Vagrant 1.2

Building a Debian box with Veewee
---------------------------------

Reference: http://wiki.debian.org/Veewee

Install veewee requirements:

<pre>
# apt-get install virtualbox linux-headers-amd64
# apt-get install ruby ruby-dev build-essential libxslt1-dev libxml2-dev
# gem install fog --version 1.8
# gem install veewee
</pre>

Using veewee:

<pre>
mkdir -p ~/repositories
cd ~/repositories
git clone https://github.com/jedi4ever/veewee
cd veewee
veewee vbox templates | grep Debian

veewee vbox define 'my-debian-7.2' 'Debian-7.2.0-amd64-netboot' --workdir=~/repositories/veewee
veewee vbox build 'my-debian-7.2'
vagrant package --base my-debian-7.2 --output bgm-debian-7.box
</pre>

Add to vagrant:

<pre>
vagrant box add my-debian-7.2 ~/repositories/veewee/my-debian-7.2.box
</pre>

You can then use the 'box' from Vagrant. Your Vagrantfile should have:

<pre>
config.vm.box = "my-debian-7.2"
</pre>

NB: in the rlbuild Vagrantfile, I'm using 'bgm-debian-7.2'.


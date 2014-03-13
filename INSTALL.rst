Install PCRTiler server on Linux
--------------------------------

`PCRTiler server <http://pcrtiler.alaingervais.org:8080/PCRTiler/>`_
needs to run inside a Java Servlet container, like Tomcat or Jetty, which in
turn needs a Java virtual machine (JVM).

Note that because only
`PCRTiler server 32 bit version (i386) <http://pcrtiler.alaingervais.org:8080/PCRTiler/download.jsp>`_
is provided, you should use Linux 32 bit. If you use Linux 64 bit, you must
install addition i386 libraries, otherwise you will see
`this "Not found" error <http://unix.stackexchange.com/questions/13391/getting-not-found-message-when-running-a-32-bit-binary-on-a-64-bit-system>`_.

On Ubuntu 64 bit:

::

  sudo apt-get install libc6-i386

Install JVM
~~~~~~~~~~~

There are many ways to install JVM.

For example, if you want to install Oracle JVM 7u51 32 bit to
``~/opt/jdk1.7.0_51``:

::

  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-i586.tar.gz
  tar xzf jdk-7u51-linux-i586.tar.gz
  mv jdk1.7.0_51 ~/opt/

Add this line to the end of ``~/.profile`` to add ``java`` command to
``PATH`` system variable, so that it can be run from any directory:

::

  PATH="$HOME/opt/jdk1.7.0_51/bin:$PATH"

Install Tomcat
~~~~~~~~~~~~~~

There are many ways to install Tomcat.

For example, if you want to install Tomcat 6.0.39 to
``~/opt/tomcat-6.0.39``:

::

  wget http://ftp.meisei-u.ac.jp/mirror/apache/dist/tomcat/tomcat-6/v6.0.39/bin/apache-tomcat-6.0.39.tar.gz
  tar xzf apache-tomcat-6.0.39.tar.gz
  mv apache-tomcat-6.0.39 ~/opt/tomcat-6.0.39


To increase memory for Tomcat to 2 GB, add this line to the top of
``~/opt/tomcat-6.0.39/bin/catalina.sh``:

::

  JAVA_OPTS="-Xmx2048m"

Install PCRTiler server to Tomcat
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   wget http://pcrtiler.alaingervais.org:8080/PCRTiler/PCRTiler-v1.42-server-linux-i386.tgz
   tar xzf PCRTiler-v1.42-server-linux-i386.tgz
   cd PCRTiler-v1.42

Edit ``install.sh`` so that it will install to ``~/opt/tomcat-6.0.39``:

::

  rm -rf $HOME/opt/tomcat-6.0.39/webapps/PCRTiler
  rm -rf $HOME/opt/tomcat-6.0.39/work/PCRTiler
  mkdir -p $HOME/opt/tomcat-6.0.39/webapps/PCRTiler
  mkdir -p $HOME/opt/tomcat-6.0.39/work/PCRTiler
  cp -r * $HOME/opt/tomcat-6.0.39/webapps/PCRTiler
  cp -r $HOME/opt/tomcat-6.0.39/webapps/PCRTiler/cache_skel/* $HOME/opt/tomcat-6.0.39/work/PCRTiler

Run ``install.sh`` to install.

Restart Tomcat:

::

  cd ~/opt/tomcat-6.0.39
  bin/shutdown.sh
  bin/startup.sh

Now you can go to http://localhost:8080/PCRTiler to see the PCRTiler web UI.
Use the UI to install genomes like Homo_sapiens. The genomes will be installed
to directory ``~/opt/tomcat-6.0.39/work/PCRTiler/genomes``.

If there's any problem, you should check log files in ``~/opt/tomcat-6.0.39/logs``
directory.

Note that the "Server statistics" page in PCRTiler
(example: http://pcrtiler.alaingervais.org:8080/PCRTiler/server.jsp)
runs commands like ``/bin/free`` to get statistics. On Ubuntu this command is
at ``/usr/bin/free``, you need to create a symbolic link:

::

  cd /bin
  sudo ln -s /usr/bin/free

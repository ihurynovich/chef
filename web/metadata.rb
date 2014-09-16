name             'web'
maintainer       'Ilya_Hurynovich'
maintainer_email 'i.hurynovich@gmail.com'
license          'All rights reserved'
description      'Installs/Configures web'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "web_apache"
depends "web_nginx"

# Copyright (c) 2015 Pepijn Oomen <oomen@piprograms.com>
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Foobar is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

from flask import Flask
from os import environ
from redis import Redis
application = Flask(__name__)

@application.route('/')
def visitor_counter():
    redis = Redis(
        host = environ.get('REDIS_SERVICE_HOST', 'redis'),
        port = environ.get('REDIS_SERVICE_PORT', '6379'),
        password = environ.get('REDIS_PASSWORD', '')
    )
    redis.incr('visits')
    visits = int(redis.get('visits'))
    return "You have been here %i times\r\n" % visits, 200, { 'Content-Type': 'text/plain' }

if __name__ == '__main__':
    application.run(debug = True)

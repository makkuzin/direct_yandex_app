set :stage, :production
server '188.120.227.156', roles: %w{web app db}, user: 'deploy'

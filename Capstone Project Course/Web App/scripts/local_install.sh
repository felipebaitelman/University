# Abort if any instruction fails
set -e

# Move to the project root dir
cd $(dirname "$0")/../

# Stop puma
bundle exec pumactl -P shared/pids/puma.pid stop

# Get last changes
git pull

bundle install

rake db:create db:migrate db:seed
rake assets:precompile

bundle exec puma -C config/puma.rb -d

echo "Deploy successful"
exit 0

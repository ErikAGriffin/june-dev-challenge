task default: %w[setup]

task :setup do
  sh 'chmod +x bin/developer_challenge'
end

# It seems that from rake, this command does nothing.
# Perhaps a security feature..?
task :path do
  sh 'export PATH=$HOME/Desktop/challenge:$PATH'
end

namespace :deploy do
  task :symlink_configs do
    on roles(:all) do
      find_exp = "find #{shared_path}/config/ \\( -name '*.yml' -or -name '*.erb' -or -name '*.rb' \\) -type f -print"
      execute "cd #{release_path}/config && for file in $(#{find_exp}); do ln -sfv $file; done"
    end
  end

  task :npm_install do
    on roles(:app, :web) do
      execute "cd #{release_path} && rm -rf node_modules"
      execute "cd #{release_path} && npm install"
    end
  end
end

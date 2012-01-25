PackageMirror::Application.routes.draw do
  match 'pkgs/:id' => 'mirrors#download', :id => /[A-Za-z0-9_\-\.%]+/
end

Rails.application.routes.draw do
	
	root 'users#index'

	get 'land' => 'users#land'

	post 'land' => 'users#login'

	post 'registration' => 'users#regi'

	get 'user/:id/edit' => 'users#userEdit'

	patch 'user/:id/swap' => 'users#swapUser'

	delete 'delete/:id' => 'users#delete'

	post 'posts/new/:id' => 'users#comment'

	delete 'delete/:id/mss' => 'users#messageDelete'

	get 'edit/:id/mss' => 'users#editMss'

	patch 'update/:id/mss' => 'users#mssUpdate'



end



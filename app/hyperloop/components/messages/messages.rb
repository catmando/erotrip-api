class Messages < Hyperloop::Router::Component

	def render
		div(class: 'row') do
			div(class: 'col-12 col-lg-9 ml-lg-auto') do
				span {'test'}

				div(class: 'messenger') do
					div(class: 'messenger-backdrop') do
						div(class: 'messenger-body') do

							# sidebar start
							div(class: 'messenger-sidebar') do
								div(class: 'messenger-search') do
									div(class: 'form-group mb-0') do
										input(class: 'form-control', placeholder: 'Szukaj', type: 'text')
									end
								end
								div(class: 'messenger-list-wrapper') do
									div(class: 'messenger-list') do

										a(class: 'm-group') do
											div(class: 'm-group-counter') do
												div(class: 'mt-1') {'3'}
											end
											div(class: 'm-group-details') do
												div(class: 'm-group-header') do
													div(class: 'm-group-text') {'Grupa/Hotline grupaaaa'}
													div(class: 'm-group-amount text-gray') {'125 osób'}
												end
												div(class: 'm-group-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
											end
										end

										a(class: 'm-person active') do
											div(class: 'm-person-image-wrapper') do
												img(src: 'assets/girl.jpg')
											end
											div(class: 'm-person-details') do
												div(class: 'm-person-header') do
													div(class: 'm-person-text') {'Joanna Kowalska z domu'}
												end
												div(class: 'm-person-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
											end
										end

										a(class: 'm-person') do
											div(class: 'm-person-image-wrapper') do
												img(src: 'assets/girl.jpg')
												div(class: 'm-person-locker') do
													i(class: 'ero-locker')
												end
											end
											div(class: 'm-person-details') do
												div(class: 'm-person-header') do
													div(class: 'm-person-text') {'Joanna Kowalska z domu'}
												end
												div(class: 'm-person-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
											end
										end

										a(class: 'm-trip') do
											div(class: 'm-trip-counter') do
												div(class: 'mt-1') {'+1'}
											end
											div(class: 'm-trip-details') do
												div(class: 'm-trip-header') do
													div(class: 'm-trip-text') {'Wycieczka'}
													div(class: 'm-trip-amount text-gray') {'22 marca'}
												end
												div(class: 'm-trip-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
											end
										end

									end
								end
							end
							# sidebar end

							# messenger main start
							div(class: 'messenger-main') do

								# messenger header start
								div(class: 'messenger-header pr-0') do
									div(class: 'g-wrapper') do
										div(class: 'g-image-wrapper') do
											img(src: 'assets/girl.jpg')
											div(class: 'g-image-locker') do
												i(class: 'ero-locker')
											end
										end
										div(class: 'messenger-profile-info') do
											div(class: 'messenger-profile-info-upper') do
												div(class: 'messenger-person-status away')
												h4(class: 'mb-0') do
													span {'Joanna'}
													span(class: 'text-gray') {'24'}
												end
												i(class: 'ero-verified-border-gray ml-2 f-s-30') do
													span(class: 'path1')
													span(class: 'path2')
													span(class: 'path3')
												end
											end

											div(class: 'messenger-profile-info-lower') do
												span(class: 'text-gray') {'2 dni temu'}
												span(class: 'text-gray') {'Poznań'}
											end
										end
									end

									div(class: 'messenger-header-buttons') do
										button(class: 'button btn icon-only icon-only-bigger btn-outline-primary btn-outline-gray mr-2', type:'button') do
											i(class: 'ero-user f-s-22')
										end
										button(class: 'button btn icon-only icon-only-bigger btn-outline-primary btn-outline-gray text-gray', type:'button') do
											i(class: 'ero-alert-circle-outline f-s-25')
										end
										button(class: 'button btn btn-link icon-only text-gray no-underline-i mr-2') do
											i(class: 'ero-cross rotated-45deg f-s-20')
										end
									end
								end

								div(class: 'messenger-header no-image-one-small-button d-none') do
									div(class: 'g-description-wrapper') do
										div(class: 'g-header') do
											h5(class: 'mb-0 g-header-text') {'Wycieczka aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
											div(class: 'g-header-additional-text text-gray f-s-15') {'18 sierpnia'}
										end
										div(class: 'g-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
									end
									div(class: 'messenger-header-buttons') do
										button(class: 'button btn btn-link icon-only text-gray no-underline-i mr-2') do
											i(class: 'ero-cross rotated-45deg f-s-20')
										end
									end
								end

								div(class: 'messenger-header image-two-small-buttons d-none') do
									div(class: 'g-wrapper') do
										div(class: 'g-image-wrapper') do
											img(src: 'assets/girl.jpg')
										end
										div(class: 'g-description-wrapper') do
											div(class: 'g-header') do
												h5(class: 'mb-0 g-header-text') {'BDSM'}
												div(class: 'g-header-additional-text text-gray f-s-15') {'18 sierpnia'}
											end
											div(class: 'g-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
										end
									end
									div(class: 'messenger-header-buttons') do
										button(class: 'button btn icon-only icon-only-bigger btn-outline-primary btn-outline-gray text-gray', type:'button') do
											i(class: 'ero-alert-circle-outline f-s-25')
										end
										button(class: 'button btn btn-link icon-only text-gray no-underline-i mr-2') do
											i(class: 'ero-cross rotated-45deg f-s-20')
										end
									end
								end

								div(class: 'messenger-header image-primary-button d-none') do
									div(class: 'g-wrapper') do
										div(class: 'g-image-wrapper') do
											img(src: 'assets/girl.jpg')
											div(class: 'g-image-locker') do
												i(class: 'ero-locker')
											end
										end
										div(class: 'g-description-wrapper') do
											p(class: 'mb-0 text-gray text-book') do
												span {'Aktualnie jesteś w anonimowy,'}
												br
												span {'Pokaż się w dowolnym momencie'}
											end
										end
									end
									button(class: 'button btn btn-secondary', type: 'button') {'Odblokuj'}
								end

								div(class: 'messenger-header image-primary-button d-none') do
									div(class: 'g-wrapper') do
										div(class: 'g-image-wrapper') do
											img(src: 'assets/girl.jpg')
											div(class: 'g-image-locker g-image-locker-right-bottom') do
												i(class: 'ero-locker')
											end
										end
										div(class: 'g-description-wrapper') do
											div(class: 'g-header') do
												h5(class: 'mb-0 g-header-text') {'Bardzo długa nazwa grupy Bardzo'}
												div(class: 'g-header-additional-text text-gray f-s-15') {'18 sierpnia'}
											end
											div(class: 'g-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
										end
									end
									button(class: 'button btn btn-secondary', type: 'button') {'Odblokuj'}
								end

								div(class: 'messenger-header image-primary-button d-none') do
									div(class: 'g-wrapper') do
										div(class: 'g-image-wrapper') do
											img(src: 'assets/girl.jpg')
											div(class: 'g-image-locker') do
												i(class: 'ero-locker')
											end
										end
										div(class: 'g-description-wrapper') do
											div(class: 'g-header') do
												h5(class: 'mb-0 g-header-text') {'Bardzo długa nazwa grupy Bardzo'}
												div(class: 'g-header-additional-text text-gray f-s-15') {'18 sierpnia'}
											end
											div(class: 'g-description text-gray text-book') {'Dziś wieczorem chętnie kogo…'}
										end
									end
									button(class: 'button btn btn-secondary', type: 'button') {'Odblokuj'}
								end
								# messenger header end

								div(class: 'messenger-chat-wrapper') do
									div(class: 'messenger-chat') do
										div(class: 'message-wrapper') do
											div(class: 'message-profile-picture') do
												img(src: 'assets/girl.jpg')
											end
											div(class: 'message') {'Hej co tam?'}
										end
										div(class: 'message-wrapper mine') do
											div(class: 'message') {'Siemaaaaa ;d'}
											div(class: 'message-timestamp') {'Dostarczono o 1:48'}
										end
									end
								end

								div(class: 'messenger-chat-warning d-none') do
									div(class: 'locker-big') do
										i(class: 'ero-locker f-s-65')
									end
									p(class: 'text-center f-s-18 text-book mt-4 mb-4') do
										span {'Emilia ukryła profil, poczekaj aż nawiąże'}
										br
										span {'z Tobą kontakt lub:'}
									end
									button(class: 'btn btn-primary btn-lg', type: 'button') {'Wyślij zaczepkę'}
								end

								div(class: 'messenger-chat-warning d-none') do
									div(class: 'image-with-locker') do
										img(src: 'assets/girl.jpg')
										div(class: 'locker') do
											i(class: 'ero-locker f-s-25')
										end
									end
									p(class: 'text-center f-s-18 text-book mt-4 mb-4') do
										span(class: 'text-medium') {'Joanna, 24 prosi o kontakt,'}
										span {'jeśli chcesz kontynuować'}
										br
										span {'rozmowę wyślij wiadomość lub odpowiedz na zaczępkę:'}
									end
									button(class: 'btn btn-primary btn-lg', type: 'button') {'Wyślij zaczepkę'}
								end

								div(class: 'messenger-textarea') do
									textarea(class: 'form-control', placeholder: 'Wpisz wiadmość, naciśnij enter żeby wysłać')
									button(class: 'btn icon-only icon-only-bigger btn-outline-primary btn-outline-gray text-gray') do
										i(class: 'ero-camera f-s-25')
									end
								end

							end
							# messenger main end

						end
					end
				end
			end
		end
	end
end
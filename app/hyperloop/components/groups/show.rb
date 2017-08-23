class GroupsShow < Hyperloop::Component
  state users: []

  after_mount do
    mutate.users User.load
  end

  def render
    DIV.row do
      DIV.col_12.col_lg_9.ml_lg_auto do
        DIV.featured.streach_me do
          DIV.patch
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
        end

        DIV.group_details.streach_me do
          DIV.patch
          DIV.group_details_wrapper do
            H3(class: 'mt-0 d-md-none') do
              'TRIP'
            end
            DIV.ea_flex.ea_align_start do
              DIV
              A(href: '#') do
                IMG(src: 'assets/girl.jpg')
              end
              DIV.text do
                H2.mt_0.d_none.d_md_block { 'TRIP' }
                P.text_book.text_gray.d_none.d_md_block  do
                  'Hydroderm is the highly desired anti_aging cream on the block. This serum restricts the occurrence of early aging sings on the skin and keep'
                end
                DIV.group_info.m do
                  P.mb_0 do
                    SPAN.text_primary {'2310'}
                    SPAN.text_gray {'użytkowników'}
                  end
                  P.mb_0 do
                    SPAN.text_primary {'70'}
                    SPAN.text_gray {'ukrytych'}
                  end
                  P.mb_0 do
                    SPAN.text_primary {'Twój profil'}
                    SPAN.text_gray {'Publiczny'}
                  end
                end
              end
            end

            BUTTON.btn.icon_only.btn_plus.btn_group(type: "button") do
              I.ero_cross
            end
            BUTTON.btn.icon_only.btn_eye.btn_group(type: "button") do
              I.ero_eye
            end
          end
        end

        FORM.search do
          DIV.search_header do
            DIV.info.f_s_16 do
              SPAN.text_primary {'2310'}
              SPAN.text_gray {'użytkowników'}
            end

            DIV.search_input do
              A.btn.btn_outline_primary.btn_outline_gray.icon_only.with_label.more.mr_3 do
                I.ero_search
              end
              Select(name: 'sorts', placeholder: 'Sortuj')
            end
          end

          DIV.row.search_body.open do
            DIV.col_12.search_header_mobile.d_md_none do
              SPAN {'Wyszukaj'}
              BUTTON.btn.btn_outline_primary.btn_outline_gray.icon_only.rotated_45deg(type: "button") do
                I.ero_cross
              end
            end

            DIV.col_12.col_xl_6.search_preferences do
              DIV.row do
                DIV.col_12.col_md_6 do
                  DIV.form_group do
                    LABEL {'Szukam'}
                    MultiSelect(placeholder: "Szukam", options: [{value: 'm', label: 'Mężczyzn'}, {value: 'f', label: 'Kobiet'}], name: 'gender[]', selection: params[:gender] || [])
                  end
                end
                DIV.col_12.col_md_6 do
                  DIV.form_group do
                    LABEL {'Szukających'}
                    MultiSelect(placeholder: "Szukających", name: 'gender_opposite[]', selection: params[:gender_opposite] || [])
                  end
                end
              end
            end

            DIV.col_12.col_xl_6.location do
              DIV.form_group do
                LABEL {'Gdzie'}
                Select(placeholder: "Gdzie", options: [{value: 1, label: 'Jeden'}, {value: 2, label: 'Dwa'}], name: 'where', selection: params[:where] || '')
              end
            end

            DIV.col_12.col_xl_6.age do
              DIV.form_group do
                LABEL {'Wiek'}
                SliderRange(name: 'age[]', selection: params[:age] || [20, 30])
              end
            end

            DIV.col_12.col_xl_6.location_range do
              DIV.form_group do
                LABEL {'Cała polska'}
                Slider(name: 'distance', selection: params[:distance] || 30 )
              end
            end

            DIV.col_12.col_xl_6.height do
              DIV.row do
                DIV.col_12.col_md_6 do
                  DIV.form_group do
                    LABEL {'Wzrost'}
                    MultiSelect(placeholder: "Wzrost", name: 'height[]', selection: params[:height] || [])
                  end
                end

                DIV.col_12.col_md_6 do
                  DIV.form_group do
                    LABEL {'Sylwetka'}
                    MultiSelect(placeholder: "Sylwetka", name: 'look[]', selection: params[:look] || [])
                  end
                end

                DIV.col_12 do
                  DIV.form_group do
                    LABEL {'Zainteresowania'}
                    MultiSelectWithLabels(placeholder: "Zainteresowania", name: 'interests[]', selection: params[:interests] || [])
                  end
                end
              end
            end

            DIV.col_12.col_xl_6.options do
              FILELDSET.form_group do
                LEGEND {'Tylko'}
                DIV.form_check.form_check_inline do
                  LABEL.form_check_label do
                    INPUT.form_check_input(type: "checkbox")
                    SPAN
                    'Zweryfikowani'
                  end
                end

                DIV.form_check.form_check_inline do
                  LABEL.form_check_label do
                    INPUT.form_check_input(type: "checkbox")
                    SPAN
                    'Ze zdjęciami'
                  end
                end
              end

              FIELDSET.form_group do
                LEGEND {'Dodatkowo'}
                DIV.form_check.form_check_inline do
                  LABEL.form_check_label do
                    INPUT.form_check_input(type: "checkbox")
                    SPAN
                    'Papierosy'
                  end
                end

                DIV.form_check.form_check_inline do
                  LABEL.form_check_label do
                    INPUT.form_check_input(type: "checkbox")
                    SPAN
                    'Alkohol'
                  end
                end
              end
            end

            DIV.col.search_footer do
              BUTTON.btn.btn_secondary.mr_4(type: "submit") {'Pokaż'}
              BUTTON.btn.btn_outline_primary.btn_outline_gray.text_gray(type: "button") {'Anuluj'}
            end
          end
        end

        DIV.row.people_wrapper do

          (0..7).to_a.each do |i|
            DIV.col_6.col_md_4.col_lg_4.col_xl_3 do
              DIV.person(class: "#{'locked' if [2,4].include?(i)}") do
                DIV.person_photo_wrapper do
                  DIV.person_actions do
                    BUTTON.btn.icon_only.btn_person.btn_heart.btn_group(type: "button") do
                      I.ero_heart
                    end
                    BUTTON.btn.icon_only.btn_person.btn_remove.btn_group.ml_2(type: "button") do
                      I.ero_cross
                    end
                  end
                  DIV.person_photo_amount.d_none.d_md_flex do
                    I.ero_photo_amount
                    SPAN.amount {'6'}
                  end
                  DIV.locker do
                    I.ero_locker
                  end
                  IMG(src: 'assets/girl.jpg')
                end

                DIV.person_info.ea_flex.ea_flex_align_start.ea_just_start do
                  DIV.person_status(class: "#{['online', 'offline', 'away'].sample}")
                  DIV.person_details do
                    DIV.person_name_age do
                      H5.mt_0.mb_0.d_inline_block.person_name do
                        SPAN {'Anna'}
                        SPAN.coma.d_none.d_md_inline_block {', '}
                      end
                      H5.mt_0.mb_0.person_age.text_gray {'24'}
                    end
                    DIV.preson_city.text_gray.d_none.d_md_block {'Warszawa'}
                  end
                end
              end
            end
          end
        end

        NAV.mt_5(aria_label: "...") do
          UL.pagination.justify_content_between do
            LI.page_item.previous.disabled do
              A.page_link(href: "#") do
                I.ero_arrow_left.mr_3
                SPAN.d_none.d_md_inline_block {'Poprzednia strona'}
              end
            end

            DIV.page_wrapper do
              LI.page_item.active do
                A.page_link(href: "") {'1'}
              end
              LI.page_item do
                A.page_link(href: "") {'2'}
              end
              LI.page_item do
                A.page_link(href: "") {'3'}
              end
              LI.page_item do
                A.page_link(href: "") {'4'}
              end
              LI.page_item do
                A.page_link(href: "") {'5'}
              end
            end

            LI.page_item.next do
              A.page_link(href: "") do
                SPAN.d_none.d_md_inline_block {'Następna strona'}
                I.ero_arrow_right.ml_3
              end
            end
          end
        end

        DIV.featured.featured_large.streach_me.mt_5 do
          DIV.patch
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
          DIV.img_wrapper do
            A(href: '#') do
              IMG(src: 'assets/girl.jpg')
            end
          end
        end

        DIV.footer.streach_me.d_none.d_xl_block do
          DIV.patch
          DIV.row.no_gutters do
            DIV.col do
              DIV.footer_stats_wrapper do
                DIV.footer_stats do
                  DIV.name {'Użytkowników'}
                  DIV.number {'2 335 542'}
                end
              end
            end
            DIV.col do
              DIV.footer_stats_wrapper do
                DIV.footer_stats do
                  DIV.name {'Zweryfikowanych'}
                  DIV.number {'2 115 542'}
                end
              end
            end
            DIV.col do
              DIV.footer_stats_wrapper do
                DIV.footer_stats do
                  DIV.name {'Online'}
                  DIV.number {'15 123'}
                end
              end
            end
            DIV.col do
              DIV.footer_stats_wrapper do
                DIV.footer_stats do
                  DIV.name {'Ukrytych'}
                  DIV.number {'75 123'}
                end
              end
            end
            DIV.col do
              DIV.footer_stats_wrapper do
                DIV.footer_stats do
                  DIV.name {'Wycieczek'}
                  DIV.number {'92 123'}
                end
              end
            end
          end
        end

        DIV.footer_info.d_lg_none do
          DIV.footer_info_text do
            DIV.text_book.text_center {'Copyright 2017 © Erotrip.pl Wszystkie prawa zastrzeżone'}
            DIV.ea_flex.ea_just_center do
              BUTTON.btn.btn_link.text_gray(type: "button") {'Kontakt'}
              BUTTON.btn.btn_link.text_gray(type: "button") {'Regulamin'}
            end
          end
        end
      end
    end

  end
end
#-*- coding: utf-8 -*-
 
Plugin.create :mikutter_shinkansen_tokaido_sanyo do
  command(:tokaido_sanyo,
    name: '東海道新幹線に乗せる',
    condition: lambda{ |opt| true },
    visible: true,
    role: :timeline) do |opt|
      # データ
      train = ["ﾉｫｿﾞｫﾐｨ","ﾋｨｶｧﾘｨ","ｺﾀﾞｧﾏｧ"]
      station = ["ﾄｰｷｮｰ","ﾐｨｼｨﾏ","ｼｨｽﾞｩｵｫｶ","ﾊｧﾏｧﾏｧﾂ","ﾅｧｺﾞｫﾔ","ｼｨﾝｵｫｻｧｶ","ﾋｨﾒｪｼﾞ","ｵｫｶｧﾔｧﾏ","ﾐｨﾊｧﾗ","ﾋｨﾛｫｼｨﾏ","ﾊｧｶｧﾀ"]

      # Create the dialog
      dialog = Gtk::Dialog.new("東海道新幹線に乗る",
                               $main_application_window,
                               Gtk::Dialog::DESTROY_WITH_PARENT,
                               [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
                               [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ])

      dialog.vbox.add(Gtk::Label.new("新幹線の種別"))
      shinkansen = Gtk::ComboBox.new(true)
      dialog.vbox.add(shinkansen)
      train.each do |s|
        shinkansen.append_text(s)
      end
      shinkansen.set_active(0)

      dialog.vbox.add(Gtk::Label.new("行き先"))
      bound = Gtk::ComboBox.new(true)
      dialog.vbox.add(bound)
      station.each do |s|
        bound.append_text(s)
      end
      bound.set_active(0)

      dialog.show_all

      result = dialog.run
      trainidx = nil
      staidx = nil
      if result == Gtk::Dialog::RESPONSE_OK
        trainidx = shinkansen.active
        staidx = bound.active
        Service.primary.post(:message =>"ﾚｨﾃﾞｨｽｴﾝﾄﾞｼﾞｪﾝﾄｩﾒﾝ。ｳｪｩｶﾑﾄｩｻﾞｼｨﾝｶｧﾝｾｪﾝ。ﾃﾞｨｽｨｽﾞｻﾞ #{train[trainidx]} ｽｩﾊﾟｧｴｸｽﾌﾟﾚｪｽ ﾊﾞｩﾝﾄﾞ ﾌｫｰ #{station[staidx]}。")
      end
      dialog.destroy
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、passwordとpassword_confirmation、last_name、first_name、ruby_last_name、ruby_first_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'emailに@がなければ登録できない' do
        @user.email = 'test.gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが全角では登録できない' do
        @user.password = 'abc12３'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'last_nameは、全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name = Faker::Name.initials
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は不正な値です")
      end

      it 'first_nameは、全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = Faker::Name.initials
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end

      it 'ruby_last_nameが空では登録できない' do
        @user.ruby_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(苗字)を入力してください", "フリガナ(苗字)は不正な値です")
      end

      it 'ruby_first_nameが空では登録できない' do
        @user.ruby_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名前)を入力してください", "フリガナ(名前)は不正な値です")
      end

      it 'ruby_last_nameは、英数字では登録できない' do
        @user.ruby_last_name = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(苗字)は不正な値です")
      end

      it 'ruby_last_nameは、漢字では登録できない' do
        @user.ruby_last_name = Gimei.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(苗字)は不正な値です")
      end

      it 'ruby_last_nameは、ひらがなでは登録できない' do
        @user.ruby_last_name = Gimei.last.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(苗字)は不正な値です")
      end

      it 'ruby_first_nameは、英数字では登録できない' do
        @user.ruby_first_name = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名前)は不正な値です")
      end

      it 'ruby_first_nameは、漢字では登録できない' do
        @user.ruby_first_name = Gimei.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名前)は不正な値です")
      end

      it 'ruby_first_nameは、ひらがなでは登録できない' do
        @user.ruby_first_name = Gimei.first.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ(名前)は不正な値です")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
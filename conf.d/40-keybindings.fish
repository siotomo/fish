# キーバインディング設定
function fish_user_key_bindings
    # peco: コマンド履歴検索
    bind \cr peco_select_history
    
    # Git: ブランチ選択
    bind \co branch
end

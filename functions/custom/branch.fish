# 重複を除去しつつ順序を保持するヘルパー関数
function __uniq_stable
  set -l seen
  while read -l line
    if not contains -- "$line" $seen
      echo "$line"
      set -a seen "$line"
    end
  end
end

# 実行後にコマンドラインが実行中のような見た目になってしまうので、再描画する関数
function __repaint_commandline
  commandline -f repaint ^/dev/null 2>/dev/null
end

function branch
  set -l recent_branches (git reflog --grep-reflog="checkout" --since="5 days ago" --format="%gd %gs" | \
                        awk '{print $7}' | \
                        __uniq_stable)
  # 削除済みのブランチを除外する
  set -l branches
  for branch_name in $recent_branches
    if git show-ref --verify --quiet refs/heads/$branch_name; or git show-ref --verify --quiet refs/remotes/origin/$branch_name
      set -a branches $branch_name
    end
  end
  
  if test (count $branches) -gt 0
    set -l choice (echo $branches | tr ' ' '\n' | fzf)

    if test -n "$choice"
      if git checkout $choice
        __repaint_commandline
      end
    else
      echo "Aborting: ブランチの切り替えに失敗しました。"
    end
  else
    echo "直近5日間以内にチェックアウトしたブランチが見つかりません"
  end
end

#!/bin/bash
# Tide プロンプトの初期設定
set -e

tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time='24-hour format' --classic_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Light --prompt_spacing=Sparse --icons='Many icons' --transient=No

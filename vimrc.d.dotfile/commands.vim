command -range WordSort <line1>,<line2>!python -c "import sys; key, value = sys.stdin.read().split('='); print '='.join([key, ','.join(sorted(value.split(',')))])" 
command IgnoreWhitespace set diffopt+=iwhite
command JsonFormat % !json-format
command JsonFormatSorted % !json-format --sorted
command Wrap windo set wrap

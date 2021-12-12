function d = load_dat(name, size)
f = fopen(name);
d = fread(f, size);
fclose(f);
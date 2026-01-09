import os

input_file = "data.sql"   
output_dir = "splits"          
inserts_per_file = 10000      

os.makedirs(output_dir, exist_ok=True)

file_count = 1
insert_count = 0
buffer = []

def write_buffer(buf, count):
    filename = os.path.join(output_dir, f"part_{count}.sql")
    with open(filename, "w", encoding="utf-8") as f:
        f.writelines(buf)
    print(f"Created {filename} with {len([l for l in buf if l.startswith('INSERT')])} INSERT(s)")

with open(input_file, "r", encoding="utf-8") as f:
    current_insert = []
    in_insert = False
    for line in f:
        stripped = line.strip()
        if stripped.upper().startswith("INSERT INTO"):
            in_insert = True
            current_insert = [line]
        elif in_insert:
            current_insert.append(line)
 
        if in_insert and stripped.endswith(";"):
            in_insert = False
            buffer.extend(current_insert)
            insert_count += 1

            if insert_count >= inserts_per_file:
                write_buffer(buffer, file_count)
                file_count += 1
                buffer = []
                insert_count = 0

if buffer:
    write_buffer(buffer, file_count)

print("Splitting terminated.")

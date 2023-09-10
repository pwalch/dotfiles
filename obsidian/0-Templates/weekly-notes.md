<%*
  if (tp.file.title.startsWith("Untitled")) {
    await tp.file.move("Week-Notes/" + tp.date.weekday("YYYY-MM-DD", 0));
  }
%>
# Today's 1-1s
```dataview
TABLE from "1-1s"
WHERE substring(file.name, 0,10) = dateformat(date(today), "yyyy-MM-dd")
```
# Today tasks
- [ ] WIP

# Week tasks
- [ ] WIP

# 1-1s follow ups:
```tasks
not done
path includes 1-1s
```

# Self development
- [ ] WIP

# Summary of the week
* Challenges
* Main things learned

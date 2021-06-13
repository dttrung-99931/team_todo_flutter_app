enum ClickAction { Edit, Remove, Click }
typedef OnItemClicked<T> = Function(T model, ClickAction action);

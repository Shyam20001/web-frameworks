from micropie import App


class Root(App):

    async def homepage(self):
        return ""
    
    async def user(self, user_id):
        return user_id
    
    async def user(self):
        if self.request.method == "POST":
            return ""

app = Root()

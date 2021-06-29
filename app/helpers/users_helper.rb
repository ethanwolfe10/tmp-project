module UsersHelper

    def all_user_groups(user, invite=false)
        Group.where(id: Subscription.where(user_id: user.id, confirmed: invite).map(&:group_id))
    end

    def not_following?
        if !Follow.find_by(follower_id: current_user.id, followed_user_id: params[:id])
            return true
        else
            Follow.find_by(follower_id: current_user.id, followed_user_id: params[:id])
        end
    end


end

/.bundle
.env
# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-*

# Ignore all logfiles and tempfiles.
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep

# Ignore pidfiles, but keep the directory.
/tmp/pids/*
!/tmp/pids/
!/tmp/pids/.keep

# Ignore uploaded files in development.
/storage/*
!/storage/.keep

/public/assets
.byebug_history

# Ignore master key for decrypting credentials and more.
/config/master.key

/public/packs
/public/packs-test
/node_modules
/yarn-error.log
yarn-debug.log*
.yarn-integrity
awk -F '"' '{
	if ($2 > 0) {
		print "@property (nonatomic, copy) NSString *"$2";";
	}
}' $1
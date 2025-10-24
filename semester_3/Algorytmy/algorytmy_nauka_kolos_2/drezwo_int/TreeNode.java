public class TreeNode {
    private int value;
    private TreeNode left;
    private TreeNode right;
    private TreeNode parent;

    public TreeNode(int value) {
        this.value = value;
        this.left = null;
        this.right = null;
        this.parent = null;
    }


    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
    public TreeNode getLeft() {
        return left;
    }

    public void setLeft(TreeNode left) {
        this.left = left;
    }

    public TreeNode getRight() {
        return right;
    }

    public void setRight(TreeNode right) {
        this.right = right;
    }

    public TreeNode getParent() {
        return parent;
    }

    public void setParent(TreeNode parent) {
        this.parent = parent;
    }

    public boolean isLeaf() {
        return left == null && right == null;
    }

    public boolean hasOnlyLeftChild() {
        return left != null && right == null;
    }

    public boolean hasOnlyRightChild() {
        return right != null && left == null;
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
